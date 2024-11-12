/*
  Warnings:

  - You are about to drop the column `Expense` on the `MonthHistory` table. All the data in the column will be lost.
  - You are about to drop the column `Income` on the `MonthHistory` table. All the data in the column will be lost.
  - You are about to drop the column `Expense` on the `YearHistory` table. All the data in the column will be lost.
  - You are about to drop the column `Income` on the `YearHistory` table. All the data in the column will be lost.
  - Added the required column `expense` to the `MonthHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `income` to the `MonthHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `expense` to the `YearHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `income` to the `YearHistory` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_MonthHistory" (
    "userId" TEXT NOT NULL,
    "day" INTEGER NOT NULL,
    "month" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "income" REAL NOT NULL,
    "expense" REAL NOT NULL,

    PRIMARY KEY ("day", "month", "year", "userId")
);
INSERT INTO "new_MonthHistory" ("day", "month", "userId", "year") SELECT "day", "month", "userId", "year" FROM "MonthHistory";
DROP TABLE "MonthHistory";
ALTER TABLE "new_MonthHistory" RENAME TO "MonthHistory";
CREATE TABLE "new_YearHistory" (
    "userId" TEXT NOT NULL,
    "month" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "income" REAL NOT NULL,
    "expense" REAL NOT NULL,

    PRIMARY KEY ("month", "year", "userId")
);
INSERT INTO "new_YearHistory" ("month", "userId", "year") SELECT "month", "userId", "year" FROM "YearHistory";
DROP TABLE "YearHistory";
ALTER TABLE "new_YearHistory" RENAME TO "YearHistory";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
