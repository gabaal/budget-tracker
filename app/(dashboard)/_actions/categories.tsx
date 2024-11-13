/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable */
"use server";

import prisma from "@/lib/prisma";
import {
  CreateCategorySchema,
  CreateCategorySchemaType,
  DeleteCategorySchema,
  DeleteCategorySchemaType,
} from "@/schema/categories";
import { currentUser } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";
import { nullable } from "zod";

export async function CreateCategory(form: CreateCategorySchemaType) {
  const parsedBody = CreateCategorySchema.safeParse(form);

  if (!parsedBody) {
    throw new Error("bad request");
  }
  const user = await currentUser();

  if (!user) {
    redirect("/sign-in");
  }
  const { name, icon, type } = parsedBody!.data!;
  return await prisma.category.create({
    data: {
      userId: user.id,
      name: name,
      icon: icon,
      type: type,
    },
  });
}

export async function DeleteCategory(form: DeleteCategorySchemaType) {
  const parsedBody = DeleteCategorySchema.safeParse(form);

  if (!parsedBody) {
    throw new Error("bad request");
  }
  const user = await currentUser();

  if (!user) {
    redirect("/sign-in");
  }

  return await prisma.category.delete({
    where: {
      name_userId_type: {
        userId: user.id,
        name: parsedBody!.data!.name,
        type: parsedBody!.data!.type,
      },
    },
  });
}
