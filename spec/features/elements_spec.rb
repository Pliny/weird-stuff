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

      it { should have_selector('.initial-description') }
      it { should_not have_selector('.description') }
    end

    describe "with admin privileges" do

      before do
        integration_login :admin
        visit root_path
      end

      it { should have_selector("form input[type=\"submit\"][value=\"SKIP\"]") }
      it { should have_selector("#admin-notification") }
      it { should have_selector("form input[type=\"submit\"][value=\"RESET\"]")}

      describe "and javascript enabled", js: true do
        self.use_transactional_fixtures = false

        before { find(".admin-form") }

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

        it "should change color schemes on every 'like'" do
          el = find('.page')
          el.should     have_selector("header.bg-color00")
          el.should     have_selector("footer.bg-color01")
          el.should_not have_selector("header.bg-color01")
          el.should_not have_selector("footer.bg-color02")

          click_button "SKIP"

          el = find('.page+.page')
          el.should have_selector("header.bg-color01")
          el.should have_selector("footer.bg-color02")
          el.should have_selector(".description.color00")
        end

        it "should have the description styling when not on initial page" do
          click_button "SKIP"
          find('.page+.page').should have_selector('.description')
          subject.should_not have_selector('.page:last-child .initial-description')
        end

        it "should show what page the user would have liked" do
          click_button "SKIP"
          find('.page+.page')
          subject.should have_selector('.page:last-child .title-middle', text: @site.name)
        end

        it "should have a link to the URL they would have liked" do
          click_button "SKIP"
          find('.page+.page')
          subject.should have_selector(".page:last-child .title-middle a[href=\"#{@site.url}\"]", text: @site.name)
        end
      end
    end
  end
end
