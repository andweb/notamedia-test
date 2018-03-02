<?php

namespace App\Http\Controllers;

use App\Repository\{BooksRepository, BooksRepositoryInterface};

class BooksController extends Controller
{
    const PER_PAGE = 10;

    protected $books;

    public function __construct(BooksRepository $books)
    {
        $this->books = $books;
    }

    public function show()
    {
        return response()->json($this->books->getPagination(static::PER_PAGE));
    }

}
