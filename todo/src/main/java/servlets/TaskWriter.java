package servlets;

import app.Task;

import java.io.PrintWriter;
import java.util.List;

class TaskWriter {

    private final List<Task> tasks;
    private final PrintWriter writer;

    public TaskWriter(List<Task> tasks, PrintWriter writer) {
        this.tasks = tasks;
        this.writer = writer;
    }

    protected void write() {
        writer.write("<html>" +
                "<meta charset=\"utf-8\">" +
                "<script>document.addEventListener('DOMContentLoaded', () => {\n" +
                "\n" +
                "    const getSort = ({ target }) => {\n" +
                "        const order = (target.dataset.order = -(target.dataset.order || -1));\n" +
                "        const index = [...target.parentNode.cells].indexOf(target);\n" +
                "        const collator = new Intl.Collator(['en', 'ru'], { numeric: true });\n" +
                "        const comparator = (index, order) => (a, b) => order * collator.compare(\n" +
                "            a.children[index].innerHTML,\n" +
                "            b.children[index].innerHTML\n" +
                "        );\n" +
                "        \n" +
                "        for(const tBody of target.closest('table').tBodies)\n" +
                "            tBody.append(...[...tBody.rows].sort(comparator(index, order)));\n" +
                "\n" +
                "        for(const cell of target.parentNode.cells)\n" +
                "            cell.classList.toggle('sorted', cell === target);\n" +
                "    };\n" +
                "    \n" +
                "    document.querySelectorAll('.table_sort thead').forEach(tableTH => tableTH.addEventListener('click', () => getSort(event)));\n" +
                "    \n" +
                "});" +
                "</script>");
        writer.write("<style>" +
                ".table_sort table {\n" +
                "    border-collapse: collapse;\n" +
                "}\n" +
                "\n" +
                ".table_sort th {\n" +
                "    color: #ffebcd;\n" +
                "    background: #008b8b;\n" +
                "    cursor: pointer;\n" +
                "}\n" +
                "\n" +
                ".table_sort td,\n" +
                ".table_sort th {\n" +
                "    width: 150px;\n" +
                "    height: 40px;\n" +
                "    text-align: center;\n" +
                "    border: 2px solid #846868;\n" +
                "}\n" +
                "\n" +
                ".table_sort tbody tr:nth-child(even) {\n" +
                "    background: #e3e3e3;\n" +
                "}\n" +
                "\n" +
                "th.sorted[data-order=\"1\"],\n" +
                "th.sorted[data-order=\"-1\"] {\n" +
                "    position: relative;\n" +
                "}\n" +
                "\n" +
                "th.sorted[data-order=\"1\"]::after,\n" +
                "th.sorted[data-order=\"-1\"]::after {\n" +
                "    right: 8px;\n" +
                "    position: absolute;\n" +
                "}\n" +
                "\n" +
                "th.sorted[data-order=\"-1\"]::after {\n" +
                "\tcontent:\"dec\"\n" +
                "}\n" +
                "\n" +
                "th.sorted[data-order=\"1\"]::after {\n" +
                "\tcontent:\"inc\"\n" +
                "}</style>");
        writer.write("<body><table border=1 class=table_sort>");
        writer.write("<thead>\n" +
                "        <tr>\n" +
                "            <th>id</th>\n" +
                "            <th>name</th>\n" +
                "            <th>done</th>\n" +
                "            <th>deadline</th>\n" +
                "        </tr>\n" +
                "    </thead>");
        writer.write("<tbody>");
        for (Task task : tasks) {
            writer.write("<tr><td>");
            writer.print(task.getId());
            writer.write("</td><td>");
            writer.print(task.getName());
            writer.write("</td><td>");
            writer.print(task.isDone());
            writer.write("</td><td>");
            writer.print(task.getDeadlineDate());
            writer.write("</td></tr>");
        }
        writer.write("</tbody></table></body></html>");
    }
    
}
