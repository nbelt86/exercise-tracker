import { Controller } from "@hotwired/stimulus" //  @hotwired/stimulus is a package
//  (a library of pre-written code) that includes a class called Controller,
// this import reaches into the package and pulls a reference to that specific
// Controller class into your file, under the name Controller so that we can
// use it the following line...
export default class extends Controller { //creates a brand new class that inherits
  // that Controller knows how to do plus the two things we add below
  static targets =  ["content"] // be able to grab an element and call it "content"
  toggleVisibility() {
    this.contentTarget.classList.toggle("hidden")
  }
}
