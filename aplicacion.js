const tasks = []

class task {
    static lastId = 0

    constructor(name) {
        this.id = ++task.lastId;
        this.name = name
        this.completed = false
        this.createdAt = new Date()
    }

    toggleCompleted() {
        this.completed = !this.completed
    }
}

const taskInput = document.getElementById('taskInput');
const addBtn = document.getElementById('addBtn');
const taskList = document.getElementById('taskList');
const allBtn = document.getElementById('allBtn');
const pendingBtn = document.getElementById('pendingBtn');
const completedBtn = document.getElementById('completedBtn');
const statTotal = document.getElementById('statTotal');
const statDone = document.getElementById('statDone');
const statPending = document.getElementById('statPending');
const statProgress = document.getElementById('statProgress');
const barFill = document.getElementById('barFill');

addBtn.addEventListener('click', () => {
  const text = taskInput.value.trim();   
  if (text === '') return;    
  const nueva = new task(text);          
  tasks.push(nueva);
  console.log("Tarea agregada:", nueva);                    
  taskInput.value = '';                
  render();                              
});

function render(lista = tasks) {         
  taskList.innerHTML = '';                

  lista.forEach(t => {
    const row = document.createElement('tr');      
    // Columna 1: checkbox
    const tdCheck = document.createElement('td');
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.checked = t.completed;
    checkbox.addEventListener('click', () => {
      t.toggleCompleted();
      render();
      
    });
    tdCheck.appendChild(checkbox);

    // Columna 2: nombre
    const tdName = document.createElement('td');
    tdName.textContent = t.name;
    if (t.completed) tdName.style.textDecoration = "line-through";

    // Columna 3: fecha
    const tdDate = document.createElement('td');
    tdDate.textContent = `${t.createdAt.toLocaleDateString('es-CO')}`;

    // Columna 4: botón eliminar
    const tdDelete = document.createElement('td');
    const delBtn = document.createElement('button');
    delBtn.textContent = "Eliminar";
    delBtn.addEventListener('click', () => eliminarTarea(t.id));
    tdDelete.appendChild(delBtn);
    
    // Armar la fila
    row.append(tdCheck, tdName, tdDate, tdDelete);
    taskList.appendChild(row);
  });
  updateStats()

  function eliminarTarea(id) {
    const index = tasks.findIndex(t => t.id === id);
    if (index !== -1) {
      tasks.splice(index, 1);
      render();
    }
  }
}
allBtn.addEventListener('click', () => render());
pendingBtn.addEventListener('click', () =>
  render(tasks.filter(t => !t.completed)));
completedBtn.addEventListener('click', () =>
  render(tasks.filter(t =>  t.completed)));

function updateStats() {
  const total = tasks.length;
  const done = tasks.filter(t => t.completed).length;
  const pending = total - done;
  const percent = total ? Math.round(done / total * 100) : 0;
  statTotal.innerHTML = `${total}<br><small>Total</small>`;
  statDone.innerHTML = `${done}<br><small>Completadas</small>`;
  statPending.innerHTML = `${pending}<br><small>Pendientes</small>`;
  statProgress.innerHTML = `${percent}%<br><small>Progreso</small>`;
  barFill.style.width = `${percent}%`;
}
