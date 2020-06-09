Content-Type: multipart/mixed; boundary="===============4105517622272807657=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Weird Droid 4 modem protocol and a way to support it
Date: Tue, 09 Jun 2020 11:00:02 -0500
Message-ID: <bf3dfd8a-d192-0c6a-d0ee-6480bea81e13@gmail.com>
In-Reply-To: <20200608235941.GA4835@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4105517622272807657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 6/8/20 6:59 PM, Pavel Machek wrote:
> Hi!
> =

> I'd really like to get support for Droid 4 modem... unfortunately it
> is quite special. Few words about Droid 4 modem protocol:
> =


<snip>

> =

> I'm not sure what is the best way to support it. I was not able to get
> atchat.c to work with it (and I don't think it is quite suitable), so
> I ended up copying it and modifying it for Droid 4 protocol.
> =

> Is that acceptable? Can you see a better way?

I don't think there's really another way.  So the approach of duplicating =

GAtChat and everything inside drivers/atmodem is likely the way to go.

But if you pursue this, we really should throw out as much of the legacy in =

gatchat as possible:

- g_at_chat_suspend / resume is likely not needed (you're probably not runn=
ing =

PPP over these, right)?
- stuff like g_at_chat_set_wakeup is only relevant for some weird modems an=
d =

probably isn't relevant here
- add_terminator / blacklist_terminator might not be needed
- Some other concepts might not be needed, like send_pdu_listing and =

send_and_expect_short_prompt.  Those are really only for weird SMS commands.
- It might also be possible to greatly simplify the GAtParser concept.
- I'd also just put this all directly into drivers/motmodem/* instead of tr=
ying =

to extend gatchat library itself.

Most importantly though, we should stop using glib.  oFono is (glacially sl=
owly) =

being ported over to ell.  So I don't really want to accept any new glib co=
de.

Regards,
-Denis
--===============4105517622272807657==--

