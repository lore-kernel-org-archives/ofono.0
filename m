Content-Type: multipart/mixed; boundary="===============3147864682158475924=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] radio settings: allow for more than one property
Date: Fri, 22 Oct 2010 09:55:46 -0500
Message-ID: <4CC1A5F2.6000900@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7D0933E3@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3147864682158475924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 10/22/2010 09:21 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

>>> Thanks. Still, I'd vote for a common checkpatch script in =

>> the oFono tree. ;)
>>>
>>
>> Are you volunteering to maintain such a beast and make sure =

>> it is up to
>> date with the kernel upstream version?
> =

> Only if I get to decide on the coding style. Otherwise, I'm proposing you=
 guys should do it. Anyway, this is just a friendly suggestion in with the =
o sav e everyone's time.
> =


Nice try ;)

>> Yes, so let me give you a case where your approach breaks:
>>
>> Set the RAT property, then run two GetProperties at the same =

>> time.  You
>> end up querying FastDormancy twice.
> =

> No you won't, because the second GetProperties query will be terminated r=
ight off the bat with ofono busy error. Again, see here:
>

I really don't want to argue about this.

SetProperty("TechnologyPreference", ..)
-> Sets RADIO_SETTINGS_MODE_CACHED

GetProperties() -> queries Fast dormancy
GetProperties() -> queries Fast dormancy
->

+	} else if (rs->driver->query_fast_dormancy) {
+		rs->driver->query_fast_dormancy(rs,
+					fast_dormancy_query_callback, rs);
+		dbus_message_unref(reply);
+		return NULL;
+	}
+

You never set pending in the FastDormancy case.

> =

> Understandable. Makes it difficult to improve on design patterns that hav=
e already been replicated, though.
> =


Nobody is against improving things, but please try to do it in the
appropriate forum.  E.g. and RFC to the mailing list or an IRC discussion.

Regards,
-Denis

--===============3147864682158475924==--

