Content-Type: multipart/mixed; boundary="===============3245544120459226725=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 0/1] use fsync in storage
Date: Tue, 08 Feb 2011 14:07:16 +0000
Message-ID: <E9010BA84901F04DBE0FC93A424E0E450109D8C9@008-AM1MPN1-035.mgdnok.nokia.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157FC4A@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3245544120459226725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 08 Feb 2011, Zabaluev Mikhail (Nokia-MS/Helsinki) wrote:
>> I would use fdatasync().
> =

> What about ensuring that file metadata are synced as well (e.g. the
> file itself cannot be lost on the filesystem)?

R=C3=A9mi already responded about fdatasync semantics, but I do
wonder a bit about directory flushing (or lack of it).

Many filesystems implement special-casing for rename() which in =

practise solves the problem, but current ofono code does not =

actually call rename but instead 'link(tmp,real);unlink(tmp)'. This =

is ok for transaction safety, but possibly problematic for data safety.

So AFAIU, even if we flush tmp (with the patch I sent today), =

and hardlink, the directory inode might not be flushed for a long =

time.

And I just noticed that e.g. btrfs (which is the default in
e.g. MeeGo) does not special case rename() in case destination is =

not overwritten (but it does have a special case for the =

overwriting-rename case -> https://btrfs.wiki.kernel.org/index.php/FAQ). =

So just using fdatasync+rename won't solve all cases either.

Hmm, so fdatasync on the file, rename and fsync on directory should =

be ok then.


--===============3245544120459226725==--

