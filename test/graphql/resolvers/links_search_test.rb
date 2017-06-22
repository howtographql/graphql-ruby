require 'test_helper'

class Resolvers::LinksSearchTest < ActiveSupport::TestCase
  def find(args)
    Resolvers::LinksSearch.call(nil, args, nil)
  end

  test 'skip option' do
    link = create :link, description: 'old'
    create :link, description: 'new'

    assert_equal find(skip: 1), [link]
  end

  test 'first option' do
    create :link, description: 'old'
    link = create :link, description: 'new'

    assert_equal find(first: 1), [link]
  end

  test 'filter option' do
    link = create :link, description: 'test content', url: 'http://test.com'
    create :link, description: 'test similar', url: 'http://test.com'

    result = find(
      filter: {
        description_contains: 'test',
        OR: [{
          url_contains: 'test',
          OR: [{
            url_contains: '.com'
          }]
        }, {
          description_contains: 'content'
        }]
      }
    )

    assert_equal result, [link]
  end

  test 'order by createdAt_ASC' do
    new = create :link, created_at: 1.week.ago
    old = create :link, created_at: 1.month.ago

    assert_equal find(orderBy: 'createdAt_ASC'), [old, new]
  end

  test 'order by createdAt_DESC' do
    new = create :link, created_at: 1.week.ago
    old = create :link, created_at: 1.month.ago

    assert_equal find(orderBy: 'createdAt_DESC'), [new, old]
  end
end
