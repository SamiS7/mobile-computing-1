import UIKit

class TableViewController: UITableViewController {
    var todoModel = TodoModel()
    let path = "https://jsonplaceholder.typicode.com/todos"
    var queue = DispatchQueue(label: "Download")

    override func viewDidLoad() {
        super.viewDidLoad()

        queue.async {
            let data = self.download()
            
            DispatchQueue.main.async {
                self.todoModel = data
                self.tableView.reloadData()
            }
        }
    }
    
    func download() -> TodoModel {
        let todoModel = TodoModel()
        let url = URL(string: self.path)!
        if let data = try? Data(contentsOf: url) {
            if let obj = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let arr = obj as? [[String:Any]] {
                print(arr)
                for todo in arr {
                    let tempTodo = Todo()

                    tempTodo.userId = todo["userId"] as! Int
                    tempTodo.id = todo["id"] as! Int
                    tempTodo.title = todo["title"] as! String
                    tempTodo.completed = todo["completed"] as! Bool
                    todoModel.todos.append(tempTodo)
                }
                }
            }
        }
        return todoModel
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoModel.todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        
        let tempTodo = self.todoModel.todos[indexPath.row]
        cell.textLabel?.text = tempTodo.title
        cell.detailTextLabel?.text = "\(tempTodo.id)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}