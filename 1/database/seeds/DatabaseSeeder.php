<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        for ($i = 1; $i <= 100; $i++) {
            DB::table('books')->insert([
                'title' => $faker->text(50),
                'author' => $faker->firstName . ' ' .  $faker->lastName,
                'year_pub' => $faker->year,
            ]);
        }
    }
}
