class Status < EnumerateIt::Base
  associate_values(
    pending: 1,
    approved: 2,
    unapproved: 3
  )
end
