require 'spec_helper'

describe "Creating Todo lists" do
	it "redirects to the Todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo List"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "My Todo list"
		fill_in "Description", with: "creating Todo lists"
		click_button "Create Todo list"

		expect(page).to have_content("My Todo list")
	end

	it "displays an error when Todo list has no Title" do
		expect(Todolist.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo List"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: ""
		fill_in "Description", with: "creating Todo lists"
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(Todolist.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("not doing today")
	end

	it "displays an error when Todo list has no Description" do
		expect(Todolist.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo List"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "grocery"
		fill_in "Description", with: ""
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(Todolist.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("grocery")
	end
end