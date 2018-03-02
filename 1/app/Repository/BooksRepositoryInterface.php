<?php
namespace App\Repository;

interface BooksRepositoryInterface
{
    public function getPagination($perPage);
}