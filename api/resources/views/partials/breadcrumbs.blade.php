<div class="max-w-7xl mx-auto py-2 px-4 sm:px-6 lg:px-8">
  <?php $link = "" ?>
  @for($i = 1; $i <= count(Request::segments()); $i++) 
  @if($i < count(Request::segments()) && $i> 0)
    <?php $link .= "/" . Request::segment($i); ?>
      @if(is_numeric(Request::segment($i)))
        @php
          $model = Request::segment($i-1);
          $model = Str::singular($model);
          $model = 'App\\Models\\' . ucfirst($model);
          $model = $model::find(Request::segment($i));
        @endphp
        

        <a style="color: rgb(59 130 246 / var(--tw-bg-opacity)); " href="<?= $link ?>">{{ $model->name }}</a>
      @else
      <a style="color: rgb(59 130 246 / var(--tw-bg-opacity)); " href="<?= $link ?>">{{ ucwords(str_replace('-',' ',Request::segment($i)))}}</a> 
      @endif
      >
    @else
    {{ucwords(str_replace('-',' ',Request::segment($i)))}}
    @endif
    @endfor
</div>
