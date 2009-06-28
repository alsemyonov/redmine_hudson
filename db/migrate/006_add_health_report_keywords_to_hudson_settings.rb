# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'hudson_settings'

class AddHealthReportKeywordsToHudsonSettings < ActiveRecord::Migration
  def self.up
    add_column :hudson_settings, :health_report_build_stability, :string, :default => ""
    add_column :hudson_settings, :health_report_test_result, :string, :default => ""
    HudsonSettings.update_all "health_report_build_stability = 'Build stability'"
    HudsonSettings.update_all "health_report_test_result = 'Test Result'"
  end

  def self.down
    remove_column :hudson_settings, :health_report_build_stability
    remove_column :hudson_settings, :health_report_test_result
  end
end
