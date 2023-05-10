# spec/factories/task.rb
FactoryBot.define do
  factory :task do
    name { "Task Name" }
    status { "MyStatus" } # ステータスの具体的な許容値が明示されていないため、一般的な文字列を仮定します。
    association :project, factory: :project
  end
end
