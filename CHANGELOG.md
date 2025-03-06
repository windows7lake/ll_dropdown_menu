## 0.8.1
* Fixed: init DropDownCascadeList with checked data, the checked data is not displayed correctly. (pr #8 by [liuhll])

## 0.8.0
* Feature:
  + support dropdown button style
  + add maskVisible property for DropDownMenu, which can control the visibility of the mask
  + add relativeOffset property for DropDownMenu, which can control the relative position of the drop-down body to the drop-down header
  + (*breaking*) change property: viewOffsetY (double) -> viewOffset (Offset)
  + add example for above features
  
## 0.7.0
* Feature:
  + add custom painter for DropDownButton
  + add maskFullScreen property for DropDownMenu
  + dispose DropDownController by user
  + add example for above features

## 0.6.4
* Feature:
  + add example for customize dropdown view

## 0.6.3
* Fixed: support to reset data by using dataController in multiple choose mode.

## 0.6.2
* Fixed: index out of range in drop_down_cascade_list

## 0.6.1
* Fixed: change the method of dataController

## 0.6.0
* Feature:
  + DropDownCascadeList: add dataController to control the data of the list.

## 0.5.0
* Feature:0.5.
  + DropDownCascadeList: remove default padding.
  + DropDownListView/DropDownGridView: add `physics` and `shrinkWrap` property.

## 0.4.0
* Feature:
  + Add listener: onExpandStateChanged and onItemChanged.
  + Switch Tab with animation.

## 0.3.0
* Feature:
  + Add more parameters to customize the drop-down menu.
  + (*breaking*) Replace `DropDownViewBuilder` with `DropDownViewWrapper`.
  + (*breaking*) Add highlight properties to `DropDownItemStyle` to control the highlight style of the drop-down menu header item.
  + (*breaking*) Change the return value of `OnDropDownHeaderUpdate` to support highlight style.
* Bug fixed:
  + DropDownListView、DropDownGridView、DropDownCascadeList did not update view after data was changed.

## 0.2.0
* Feature:
    + Add `OnDropDownHeaderUpdate` callback to update the text of the drop-down menu header.
    + (*breaking*) Wrapper the style of dropdown menu: DropDownBoxStyle、DropDownItemStyle、DropDownButtonStyle.
    + (*breaking*) Replace DropDownMenu item with `WrapperButton`.

## 0.1.3
* Remove preview image

## 0.1.2
* Refactor code
* Update README

## 0.1.1
* Refactor code
* Update README

## 0.1.0

* Support using `Stack` or `Overlay` to implement drop-down menu.
* Customize the drop-down menu bar header.
* Customize the main content of the drop-down menu.
* Control the display and hiding of drop-down menu.
* Support use in `CustomScrollView` and `NestedScrollView`.
* Basic drop-down menu implementation: `ListView`, `GridView`, `CascadeList` (cascading list).
* Support single and multiple selection operations.