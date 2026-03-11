const express = require('express')
const mysql = require('mysql')
const cors = require('cors')

const app = express()
app.use(cors())
app.use(express.json())

const db = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'root',
    database:'admin_amcen'
})

db.connect(err => {
    if(err){
        console.log(err)
    }else{
        console.log("MySQL Connected")
    }
})

app.get('/schedule', (req,res)=>{

    const sql = `
    SELECT schedule_events.*, machines.machine_name
    FROM schedule_events
    LEFT JOIN machines
    ON schedule_events.machine_id = machines.id
    ORDER BY start_time
    `

    db.query(sql,(err,result)=>{
        if(err){
            res.send(err)
        }else{
            res.json(result)
        }
    })

})


/* ADD MAINTENANCE EVENT */

app.post('/maintenance',(req,res)=>{

    const {title,machine_id,staff_name,start_time,end_time,notes} = req.body

    const sql = `
    INSERT INTO schedule_events
    (title,event_type,machine_id,staff_name,start_time,end_time,status,notes)
    VALUES (?,?,?, ?,?,?,?,?)
    `

    db.query(sql,
    [
        title,
        'maintenance',
        machine_id,
        staff_name,
        start_time,
        end_time,
        'pending',
        notes
    ],
    (err,result)=>{
        if(err){
            res.send(err)
        }else{
            res.json({message:"Maintenance Scheduled"})
        }
    })

})


app.listen(3000,()=>{
    console.log("Server running on port 3000")
})