<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;

class BooksTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testBooksPagination()
    {
        $response = $this->get('/books?page=2');

        $response->assertStatus(200);
        $response->assertJsonStructure(
            [
                "current_page",
                "data"  => [
                    [
                        "title",
                        "author",
                        "year_pub",
                    ],
                ],
                "first_page_url",
                "from",
                "last_page",
                "last_page_url",
                "next_page_url",
                "path",
                "per_page",
                "prev_page_url",
                "to",
                "total",
            ]
        );
        $this->assertEquals(10, count($response->original["data"]));
        $this->assertEquals(2, $response->original["current_page"]);
    }
}
