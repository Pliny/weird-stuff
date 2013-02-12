require 'spec_helper'

describe "Elements" do

  subject { page.body }

  describe "index" do

    before do
      @site = FactoryGirl.create(:weird_site)
    end

    describe "without admin privileges" do

      before { visit root_path }

      it { should have_selector('#fb-root') }
      it { should have_selector(".facebook-like[data-href=\"#{@site.url}\"]") }
      it { should have_selector(".page") }
      it { should_not have_selector("form input[type=\"submit\"]") }
      it { should_not have_selector("#admin-notification") }
    end

    describe "with admin privileges" do

      before do
        integration_login :admin
        visit root_path
      end

      it { should have_selector("form input[type=\"submit\"]") }
      it { should have_selector("#admin-notification") }

      describe "and javascript enabled", js: true do
        self.use_transactional_fixtures = false

        before { find(".ws-btn") }

        after do
          # Do not delete data in schema table
          ActiveRecord::Base.connection.tables.each do |table|
            model_name = table.camelize.singularize
            if model_name != "SchemaMigration"
              model_name.constantize.delete_all
            end
          end
        end

        it "should work with capybara-webkit" do
          click_button "SKIP"
          find('.page+.page')
        end
      end
    end
  end
end
