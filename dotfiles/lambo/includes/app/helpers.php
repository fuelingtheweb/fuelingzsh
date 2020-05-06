<?php

function onRoute($name)
{
    return request()->route()->getName() === $name;
}

function user()
{
    return auth()->user();
}

function carbon()
{
    return new Carbon\Carbon;
}
