FactoryGirl.define do
  factory :raw_crimes do
    sequence :guid do |n|
      "GUID#{n}"
    end
    link "www.foo-bar.com"
    title "Mord und Totschlag in Moabit und Wedding"
    text "In der Turmstrasse und der Osloer Strasse kam es"
    date DateTime.now
  end
end
