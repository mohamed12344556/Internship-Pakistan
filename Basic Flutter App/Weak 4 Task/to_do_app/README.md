# ❣️ Taskoo APP

# Description
This is a basic To-Do List application built using Flutter. It allows users to create, edit, delete, and mark tasks as completed. The app stores tasks locally so that they persist even after closing the app. The UI is simple and user-friendly, with smooth navigation between screens.

## Key Features
Home Screen: Displays a list of tasks with checkboxes to mark them as completed.
Add Task: A screen where users can input a task name and description.
Edit Task: Users can modify any task by tapping on it, and changes are saved immediately.
Delete Task: A feature to remove tasks from the list.
Mark as Completed: Tasks can be marked as completed, and completed tasks are visually distinguished using strikethrough text.
Local Storage: Tasks are stored locally using shared_preferences or sqflite to ensure persistence after the app is closed.
# Screenshots
![splash](https://github.com/user-attachments/assets/6e5c619f-63b5-49ac-a703-fbdb0b0472f5)
![homepage](https://github.com/user-attachments/assets/64f853ae-e43c-4700-9045-bc8599fc38b8)
![checked task](https://github.com/user-attachments/assets/490c63ec-7a4f-41ce-b18a-8483d83ade25)
![add Task](https://github.com/user-attachments/assets/efb2f7f6-6b1f-4caa-855c-36f99c3218cd)
![delete task](https://github.com/user-attachments/assets/674e6226-e440-4568-8f05-0e7fce45eedd)
![edit And show detailes task](https://github.com/user-attachments/assets/62e7dc50-8964-4f89-bcf0-3ffc760fe1a7)
![edit task](https://github.com/user-attachments/assets/5caf4561-5ec0-4ecf-a2eb-8bc97874ff6d)
![detailes task](https://github.com/user-attachments/assets/180d581c-e900-419b-895d-41eab5c0213c)



# Dependencies
shared_preferences For local storage

# How it Works
The Home Screen shows the list of tasks, with each task having a checkbox. Completed tasks are distinguished with a strikethrough or color change.
The Add Task Screen allows users to input a task and description. When saved, the task appears on the Home Screen.
Users can tap any task to edit it, and the details will be pre-filled in the Edit Task Screen.
Deleting tasks is done by tapping the delete button, and the list updates immediately.
Tasks remain saved even after closing the app due to local storage implementation.
