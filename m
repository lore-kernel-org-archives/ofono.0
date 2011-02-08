Content-Type: multipart/mixed; boundary="===============5970527001751484417=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [RFC 0/1] use fsync in storage
Date: Tue, 08 Feb 2011 13:47:51 +0200
Message-ID: <1297165672-3217-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5970527001751484417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

this is potentially a bit controversial, so sending as RFC.

Storage write_file() is used for SMS spooling (both in core for fragments a=
nd
in e.g. Marcel's history plugin patches). As we want to be sure we don't ack
SMS'es to network until we have succesfully stored them on device, I think =
we
need to use fsync() when storing the data. I know this is strictly not need=
ed in
all systems (e.g. with ext3), and can be expensive on some systems (again
ext3), but I still think this is the right thing to do (especially with btr=
fs,
ext4, xfs, et al now commonly used).

I know there's been a lot of discussion around fsync() usage (especially
related to pre-2.6.30 ext4), but I think this specific case of SMS =

delivery is one where fsync definitely makes sense (similar to MTA usage).
I'm also aware this is not bullet proof (e.g. there are still hardware
caches not covered by fsync at all), but this is just one easy step
to increase system reliability and predictability.

A few questions:

1) Do we agree that fsync should be used?

2) Should storage provide also the old variant of write_file (e.g.
   transactionally safe, but not syncing). I see at least simfs
   is using write_file a lot as well. With this patch I just modified =

   write_file semantics for simplicity, but I could add a variant
   as well.

3) Is it ok, build-wise, for ofono to require availability fdatasync()
   (which I think would be sufficient in this case and slightly =

   less expensive).

Kai Vehmanen (1):
  storage: make write_file synchronous with fsync

 src/storage.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)


--===============5970527001751484417==--

