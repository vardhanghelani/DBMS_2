1.db.Student.distinct("CITY")


2.db.Student.aggregate([
  { $group: { _id: "$CITY", count: { $sum: 1 } } }
])


3.db.Student.aggregate([
  { $group: { _id: null, totalFees: { $sum: "$FEES" } } }
])

4.db.Student.aggregate([
  { $group: { _id: null, avgFees: { $avg: "$FEES" } } }
])

5.db.Student.aggregate([
  { $group: { _id: null, maxFees: { $max: "$FEES" }, minFees: { $min: "$FEES" } } }
])

6.db.Student.aggregate([
  { $group: { _id: "$CITY", totalFees: { $sum: "$FEES" } } }
])

7.db.Student.aggregate([
  { $group: { _id: "$GENDER", maxFees: { $max: "$FEES" } } }
])

8.db.Student.aggregate([
  { $group: { _id: "$CITY", maxFees: { $max: "$FEES" }, minFees: { $min: "$FEES" } } }
])

9.db.Student.countDocuments({ CITY: "Baroda" })

10.db.Student.aggregate([
  { $match: { CITY: "Rajkot" } },
  { $group: { _id: "$CITY", avgFees: { $avg: "$FEES" } } }
])

11.db.Student.aggregate([
  { $group: { _id: { DEPARTMENT: "$DEPARTMENT", GENDER: "$GENDER" }, count: { $sum: 1 } } }
])

12.db.Student.aggregate([
  { $group: { _id: "$DEPARTMENT", totalFees: { $sum: "$FEES" } } }
])

13.db.Student.aggregate([
  { $group: { _id: { CITY: "$CITY", GENDER: "$GENDER" }, minFees: { $min: "$FEES" } } }
])

14.db.Student.find().sort({ FEES: -1 }).limit(5)

15.db.Student.aggregate([
  { $group: { _id: "$CITY", avgFees: { $avg: "$FEES" }, count: { $sum: 1 } } },
  { $match: { count: { $gt: 1 } } }
])

16.db.Student.aggregate([
  { $match: { DEPARTMENT: { $in: ["CE", "Mechanical"] } } },
  { $group: { _id: null, totalFees: { $sum: "$FEES" } } }
])

17.db.Student.aggregate([
  { $group: { _id: { DEPARTMENT: "$DEPARTMENT", GENDER: "$GENDER" }, count: { $sum: 1 } } }
])

18.db.Student.aggregate([
  { $match: { CITY: "Rajkot" } },
  { $group: { _id: "$DEPARTMENT", avgFees: { $avg: "$FEES" } } }
])

19.db.Student.aggregate([
  { $group: { _id: "$SEM", totalFees: { $sum: "$FEES" }, avgFees: { $avg: "$FEES" } } },
  { $sort: { totalFees: -1 } }
])

20.db.Student.aggregate([
  { $group: { _id: "$CITY", totalFees: { $sum: "$FEES" } } },
  { $sort: { totalFees: -1 } },
  { $limit: 3 }
])




