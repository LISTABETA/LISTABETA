module SeoHelper
  def meta_tags_for(page)
    { title: I18n.t('meta_tags.pages.'+page+'.title'),
      description: I18n.t('meta_tags.pages.'+page+'.description'),
      keywords: I18n.t('meta_tags.pages.'+page+'.keywords'),
      url: startups_url,
      image: image_url('logo-azul.png'),
      og: { url: startups_url,
            type: 'blog',
            title: I18n.t('meta_tags.pages.'+page+'.og.title'),
            image: image_url('logo-azul.png'),
            locale: I18n.t('meta_tags.og.locale'),
            site_name: 'cosmit.me',
            description: I18n.t('meta_tags.pages.'+page+'.og.description')
          },
      twitter: {
        card: I18n.t('meta_tags.pages.'+page+'.twitter.card'),
        site: '@LISTABETAbr',
        description: I18n.t('meta_tags.pages.'+page+'.twitter.description'),
        image: image_url('logo-azul.png'),
        url: startups_url
      }
    }
  end

  def meta_tags_for_startup(startup)
    {
      title: "LISTABETA | "+startup.name,
      description: startup.pitch,
      keywords: startup.market_list.join(', '),
      url: startup_url(startup),
      image: startup.screenshot_url,
      og: { url: startup_url(startup),
            type: 'website',
            title: startup.name,
            image: startup.screenshot_url,
            site_name: 'listabeta.com.br',
            description: startup.pitch,
            locale: I18n.t('meta_tags.og.locale')
          },
      twitter: {
        url: startup_url(startup),
        card: 'summary_large_image',
        site: '@LISTABETAbr',
        title: startup.name,
        image: startup.screenshot_url,
        description: startup.pitch
      }
    }
  end
end
