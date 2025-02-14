#########################################################{
# PURPOSE
# Provides a template for dynamically creating and formatting HTML links for
# navigation between dashboards including the transfer of filter values.
#
# SOURCE
# none (This template can only be EXTENDED into another view)
#
# STYLES
# This template provides three styles for the html links. Pick which one to use
# with parameter_navigation_style
#   1. horizontal bar with gray background and cortex image
#          parameter label: "Hyperlinks - Center Aligned in Box"
#          parameter value: "bar"
#   2. tabbed with cortex image
#          parameter label: "Tabs"
#          parameter value: "tab"
#   3. small text with links only (no image or unique formatting)
#          parameter label: "Hyperlinks - Left Aligned - No Border - Small font"
#          parameter value:  "small"
#
# To add or modify styles, edit the <!--Define Styles--> section in the navigation dimension
#
# FILTERS
# This template allows a dasboard to pass up to 10 possible filters. Modify this template if
# more filters are needed. Edit the <!-- Define Filters --> sections.
#
#
# STEPS TO EXTEND THIS TEMPLATE
# When you extend this template, make the REQUIRED customizations by following these steps:
# 1. create new view
# 2. add "extend: navigation_template" parameter (use name of this view)
# 3. edit dash_bindings dimension
#    - Update the "sql" property to include a list of dashboard IDs and corresponding names
#      (or link text) using the following pattern:
#         ID1|Link1||ID2|Link2
#    - for UDD dashboards use numeric id:
#       sql: '131|Dashboard 1 Link Text||132|Dashboard 2 Link Text' ;;
#    - for LookML dashboards use dashboard name with or without model name:
#       sql: 'dashboard_name1|Dashboard 1||dashboard_name2|Dashboard 2';;
#       sql: 'model_name::dashboard_name1|Dashboard 1||model_name::dashboard_name2|Dashboard 2';;
#
# 4. edit filter_bindings dimension
#    add list of filters that should be passed from one dashboard to another
#           sql: 'filter1|Filter 1 Name||filter2|Filter 2 Name' ;;
#
# 5. edit filter1 to filterN (up to 10) dimensions to unhide and label
#
# 6. update parameter_tab_focus with allowed values to match the number of dashboards
#
# USING IN A DASHBOARD
# 1. Once the extending view has been created, modified, add to an Explore using a bare join:
#       explore: balance_sheet {
#           join: balance_sheet_navigation_ext {
#           view_label: "🔍 Filters & 🛠 Tools"
#           relationship: one_to_one
#           sql:  ;;
#       }}
# 2. Open the Explore and add "navigation" dimension to a Single Value Visualization
# 3. Add the navigation parameters as filters and set to desired values
#           navigation_style = "Hyperlinks - Left Aligned - No Border - Small font"
#           navigation_tab_focus = 1 for Dashboard 1. Set to 2 for Dashboard 2 and so on
# 4. Add Visualization to each of the dashboards and map dashboard filters to pass values
#    to Filters 1 to N accordingly
#
#    LookML example of the dashboard element is below:
#     - title: navigation
#       name: navigation
#       explore: profit_and_loss
#       type: single_value
#       fields: [profit_and_loss_navigation_ext.navigation]
#       filters:
#         profit_and_loss_navigation_ext.navigation_focus_page: '1'
#         profit_and_loss_navigation_ext.navigation_style: 'small'
#       show_single_value_title: false
#       show_comparison: false
#       listen:
#         Hierarchy: profit_and_loss_navigation_ext.filter1
#         Display Timeframe: profit_and_loss_navigation_ext.filter2
#         Select Fiscal Timeframe: profit_and_loss_navigation_ext.filter3
#         Global Currency: profit_and_loss_navigation_ext.filter4
#         Company Code: profit_and_loss_navigation_ext.filter5
#         Ledger Name: profit_and_loss_navigation_ext.filter6
#         Top Hierarchy Level to Display: profit_and_loss_navigation_ext.filter7
#         Combine Selected Timeframes?: profit_and_loss_navigation_ext.filter8
#########################################################}

view: navigation_template {
  extension: required
  ########################################
  ###### Fields *requiring override* in extension
  ########################################

  dimension: dash_bindings {
    hidden: yes
    type: string
    sql: '131|Dashboard 1||132|Dashboard 2' ;;
  }

  dimension: filter_bindings {
    hidden: yes
    type: string
    sql: 'filter1|Filter 1 Name||filter1|Filter 2 Name' ;;
  }

# <!-- Define Filters -->
  # ** override hidden and label in extension as required **
  # ** Add more as required, currently supports 10 **
  filter: filter1 { hidden: yes label: "filter1"}
  filter: filter2 { hidden: yes label: "filter2"}
  filter: filter3 { hidden: yes label: "filter3"}
  filter: filter4 { hidden: yes label: "filter4"}
  filter: filter5 { hidden: yes label: "filter5"}
  filter: filter6 { hidden: yes label: "filter6"}
  filter: filter7 { hidden: yes label: "filter7"}
  filter: filter8 { hidden: yes label: "filter8"}
  filter: filter9 { hidden: yes label: "filter9"}
  filter: filter10 { hidden: yes label: "filter10" }

  ########################################
  ###### Fields *optionally overriden* in extension
  ########################################

  dimension: item_delimiter {
    hidden: yes
    type: string
    sql: '||' ;;
  }

  dimension: value_delimiter {
    hidden: yes
    type: string
    sql: '|' ;;
  }

# <!-- Define Styles -->
  # use parameter to choose navigation style
  parameter: navigation_style {
    hidden: no
    type: unquoted
    description: "Select navigation style (e.g., Tabs, Hyperlinks in Box or Hyperlinks with No Styling)"
    allowed_value: {label: "Hyperlinks - Center Aligned in Box" value: "bar"}
    allowed_value: {label: "Tabs" value: "tabs"}
    allowed_value: {label: "Hyperlinks - Left Aligned - No Border - Small font" value: "small"}
    default_value: "tabs"
  }

  # use parameter to set focus page until bug with _explore._dashboard_url is fixed
  # update allowed values to match number of dashboards defined in extension
  parameter: navigation_focus_page {
    hidden: no
    description: "Used in dashboard navigation to set focus on selected dashboard page"
    type: unquoted
    allowed_value: {value:"1"}
    allowed_value: {value:"2"}
    default_value: "1"
  }

  ########################################
  ###### Navbar definition
  ########################################

  #AQUI VA EL CODIGO ELEVEN


}
