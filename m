Content-Type: multipart/mixed; boundary="===============2775252142187515959=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 1/6] gprs-provision: add driver API header
Date: Fri, 21 Jan 2011 09:39:18 +0200
Message-ID: <1295595558.21986.35.camel@jsaunama-desktop>
In-Reply-To: <4D38AE66.8030805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2775252142187515959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, 2011-01-20 at 15:51 -0600, Denis Kenzior wrote:
> So I don't really see the point in an asynchronous provisioning driver.
>  If you want to do this over D-Bus or something then you might as well
> provision via the ConnectionManager interface.  The other problem with
> being async is that is nearly impossible to support multiple
> provisioning plugins properly.  I'd rather not deal with the race
> conditions.
> =

> If we can't make the lookup fast enough to be done synchronously, then I
> think we should give up.

The reason for asyncronous API is still that SPN value reading from SIM.
Is there any way to make sure it is available synchronously when
provisioning is run?
And what do you mean with it being impossible to support multiple
provisioning plugins properly? Plugins are run one after another until
first returns something.
Race conditions I tried to address in gprs, so if gprs atom goes away
while provisioning is running nothing bad should happen. But sure, there
might something else, and hopefully someone could point them.

Of cause there is always the possibility to do all this provisioning
stuff outside of oFono, especially if we add SPN property to SIM API.

> I also don't see the point of instantiating these per modem.  The API
> already has all the information it needs in the get_settings call.  So
> having the plugin allocate its data in the plugin init function and free
> it there seems enough to me.

This I agree, earlier patches did it that way. I only changed this since
Marcel wished that all this kind of driver interfaces (like nettime)
would look similar. Or did I misunderstand that?

--Jukka



--===============2775252142187515959==--

