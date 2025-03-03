db.stock.createIndex({ company: 1 })
db.Stock.createIndex({ sector: 1, sales: 1 })
db.Stock.getIndexes()
db.Stock.dropIndex({ company: 1 })
var cursor = db.Stock.find();

while (cursor.hasNext()) {
    printjson(cursor.next());
}
var cursor = db.Stock.find().limit(3);


while (cursor.hasNext()) {
    printjson(cursor.next());

var cursor = db.Stock.find().sort({ sales: -1 });

var cursor = db.Stock.find().skip(2);

while (cursor.hasNext()) {
    printjson(cursor.next());
}

var documentsArray = db.Stock.find().toArray();

db.createCollection("Companies", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["company", "sector"],
         properties: {
            company: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            sector: {
               bsonType: "string",
               description: "must be a string and is required"
            }
         }
      }
   }
})