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
    link1 = create :link, description: 'test1', url: 'http://test1.com'
    link2 = create :link, description: 'test2', url: 'http://test2.com'
    link3 = create :link, description: 'test3', url: 'http://test3.com'
    create :link, description: 'test4', url: 'http://test4.com'

    result = find(
      filter: {
        'description_contains' => 'test1',
        'OR' => [{
          'url_contains' => 'test2',
          'OR' => [{
            'url_contains' => 'test3'
          }]
        }, {
          'description_contains' => 'test2'
        }]
      }
    )

    assert_equal result.map(&:description).sort, [link1, link2, link3].map(&:description).sort
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
