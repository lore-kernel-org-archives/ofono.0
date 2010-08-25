Content-Type: multipart/mixed; boundary="===============3921186612283917942=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] sim: read EFiidf
Date: Wed, 25 Aug 2010 17:54:41 -0500
Message-ID: <4C759F31.6080103@gmail.com>
In-Reply-To: <20100825153602.100e6132@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3921186612283917942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

>> My initial feeling is that we should treat blocks just like we treat
>> records today. We should not write them to separate files.
>>
>> Can we unify the two approaches somehow?  Perhaps by storing a bitmap in
>> the cache header, and update the bitmap every time we write the record /
>> block to the cache.  We can use idmap.c for bitmap management easily
>> enough...
> =

> The complication is that you can read blocks out of order.  For example,
> say you want to retrieve an image that is contained in blocks 4 and 5
> of the EFiidf.  But you don=C2=B4t care about blocks 1,2,3 and we don=C2=
=B4t

That is not really a complication, you handle this already...

> read them.  So to cache blocks 4 and 5 when blocks 1, 2, 3 don=C2=B4t exi=
st
> in the same file would mean either writing blocks 4 and 5 before blocks
> 1,2,3 and then keeping a map of where each block would be located in
> the file (which would require more space than a bit), or leaving a lot
> of blank space for blocks 1, 2, 3 and putting blocks 4 and 5 into the file
> after the blank space, which seems wasteful to me since we may never
> need to read 1, 2, 3.

I'm actually not worried about wasting space.  These files are max 65k,
most likely less and there's a few of them.  Devices these days come
with 16G+ of flash...  Also, it is not like directories are 'free'.
Most file systems allocate at least several KB for that...  Given how
tiny these files are, we'd probably come out ahead more often than not.

And if we ever support EFext for EFfdn, EFbdn, EFadn, etc we'll need
selective record caching as well.  This leads to 'wasted space' too.

Regards,
-Denis

--===============3921186612283917942==--

