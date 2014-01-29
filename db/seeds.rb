# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ResumeSection.delete_all
section1 = ResumeSection.create(order: 1, resume_id: 1)
section2 = ResumeSection.create(order: 2, resume_id: 1)

ResumeLine.delete_all
line1 = ResumeLine.create(order: 1, resume_section_id: section1.id)
line2 = ResumeLine.create(order: 2, resume_section_id: section1.id)
line3 = ResumeLine.create(order: 1, resume_section_id: section2.id)

ResumeItem.delete_all
ResumeItem.create(text: 'RESUME_ITEM_1', order: 1, resume_line_id: line1.id)
ResumeItem.create(text: 'RESUME_ITEM_2', order: 1, resume_line_id: line2.id)
ResumeItem.create(text: 'RESUME_ITEM_3', order: 2, resume_line_id: line2.id)
ResumeItem.create(text: 'RESUME_ITEM_4', order: 3, resume_line_id: line2.id)
ResumeItem.create(text: 'RESUME_ITEM_5', order: 1, resume_line_id: line3.id)
ResumeItem.create(text: 'RESUME_ITEM_6', order: 2, resume_line_id: line3.id)