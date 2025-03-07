require "rails_helper"

RSpec.describe FramesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/frames").to route_to("frames#index")
    end

    it "routes to #new" do
      expect(get: "/frames/new").to route_to("frames#new")
    end

    it "routes to #show" do
      expect(get: "/frames/1").to route_to("frames#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/frames/1/edit").to route_to("frames#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/frames").to route_to("frames#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/frames/1").to route_to("frames#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/frames/1").to route_to("frames#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/frames/1").to route_to("frames#destroy", id: "1")
    end
  end
end
