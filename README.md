# todo_management_app

This is a task management application.


## database design

## tasks table

|Column      |Type       |Option                         |
|------------|-----------|-------------------------------|
|title       |string     |null: false                    |
|description |text       |null: false                    |
|user_id     |integer    |null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :task_tags


## tags table

|Column      |Type       |Option                      |
|------------|-----------|----------------------------|
|tag_name    |string     |null: false                 |


### Association
- has_many :task_tags


## task_tags table

|Column      |Type       |Option                         |
|------------|-----------|-------------------------------|
|task_id     |integer    |null: false, foreign_key: true |
|tag_id      |integer    |null: false, foreign_key: true |

### Association
- belongs_to :task
- belongs_to :tag


## users table

|Column      |Type       |Option                               |
|------------|-----------|-------------------------------------|
|name        |string     |null: false                          |
|email       |string     |null: false, add_index, unique: true |
|group_id    |integer    |                                     |

### Association
- has_many :tasks
- belongs_to :group


## groups table

|Column      |Type       |Option                               |
|------------|-----------|-------------------------------------|
|group_name  |string     |null: false, unique: true            |

### Association
- has_many :users
- has_many :tasks


