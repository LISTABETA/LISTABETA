class Status < EnumerateIt::Base
  associate_values(
    draft: 0,
    pending: 1,
    approved: 2,
    unapproved: 3
  )
end
