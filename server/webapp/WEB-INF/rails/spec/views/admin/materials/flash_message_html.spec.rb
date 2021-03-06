##########################GO-LICENSE-START################################
# Copyright 2014 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################GO-LICENSE-END##################################

require File.join(File.dirname(__FILE__), "/../../../spec_helper")

describe "admin/materials/hg/new.html.erb" do

  include GoUtil

  before :each do
    assigns[:material] = @material = HgMaterial.new("url", nil)
    assigns[:cruise_config] = @cruise_config = CruiseConfig.new
    ReflectionUtil.setField(@cruise_config, "md5", "abc")
  end

  it "should render reload option when the config file MD5 has changed under the message" do
    assigns[:config_file_conflict] = true
    in_params(:pipeline_name => "pipeline_name")

    render "admin/materials/hg/new.html"
    response.body.should have_tag("#config_save_actions button.reload_config#reload_config", "Reload")
    response.body.should have_tag("#config_save_actions label", "This will refresh the page and you will lose your changes on this page.")
  end

  it "should render help links next to flash message" do
    assigns[:flash_message] = 'flash_key'
    flash = mock('flash')
    flash.should_receive(:flashClass).and_return('error')
    flash.should_receive(:to_s).and_return('some random message')
    template.stub(:load_flash_message).with('flash_key').and_return(flash)
    assigns[:flash_help_link] = "<a href='foo'>Foo</a>"

    render "shared/_flash_message.html"

    response.body.should have_tag("p.error") do
      with_tag("a[href='foo']", "Foo")
    end
  end

  it "should not bomb when no help link exists" do
    assigns[:flash_message] = 'flash_key'
    flash = mock('flash')
    flash.should_receive(:flashClass).and_return('error')
    flash.should_receive(:to_s).and_return('some random message')
    template.stub(:load_flash_message).with('flash_key').and_return(flash)
    assigns[:flash_help_link] = nil

    render "shared/_flash_message.html"

    response.body.should have_tag("p.error") do
      without_tag("a[href='foo']", "Foo")
    end
  end

  it "should not render reload option when the config file has not conflicted" do
    in_params(:pipeline_name => "pipeline_name")

    render "admin/materials/hg/new.html"
    response.body.should_not have_tag("#config_save_actions")
  end
end
