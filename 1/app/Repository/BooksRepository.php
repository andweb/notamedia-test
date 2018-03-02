<?php
namespace App\Repository;

use App\Models\Books;

class BooksRepository implements BooksRepositoryInterface
{
    protected $model;
    protected $cols = ['title', 'author', 'year_pub'];

    public function __construct(Books $model)
    {
        $this->model = $model;
    }

    public function getPagination($perPage)
    {
        $modelClass = $this->model;
        return $modelClass::paginate($perPage, $this->cols)->toArray();
    }
}