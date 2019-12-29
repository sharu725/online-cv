---
layout: post-default
title: Blog
permalink: /blog
---

{% if page.url == "/blog" %}

<!-- Featured
================================================== -->
<section class="featured-posts">
    <div class="section-title">
        <h2><span>Featured</span></h2>
    </div>
    <div class="row">

    {% for post in site.posts %}

        {% if post.featured == true %}

            {% include featuredbox.html %}

        {% endif %}

    {% endfor %}

    </div>
</section>

{% endif %}

<!-- Posts Index
================================================== -->
<section class="recent-posts">

    <div class="section-title">

        <h2><span>All Stories</span></h2>

    </div>

    <div class="row listrecent">

        {% for post in site.posts %}

        {% include postbox.html %}

        {% endfor %}

    </div>

</section>

<!-- Pagination
================================================== -->
<div class="bottompagination">
<div class="pointerup"><i class="fa fa-caret-up"></i></div>
<span class="navigation" role="navigation">
    {% include pagination.html %}
</span>
</div>

