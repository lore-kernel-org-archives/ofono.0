Content-Type: multipart/mixed; boundary="===============4428623849969698382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 09:07:07 -0600
Message-ID: <4D30669B.9080403@gmail.com>
In-Reply-To: <1294987983.29263.24.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4428623849969698382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 01/14/2011 12:53 AM, Jukka Saunamaki wrote:
> Hello Denis,
> =

> On Thu, 2011-01-13 at 09:57 -0600, Denis Kenzior wrote:
>>> Some virtual operators are using the same MCC/MNC as their host, or some
>>> operators have several different trade names, and these can have
>>> different access settings (at least different UI visible name). =

>>> SPN in SIM typically tells these cases apart. This is why I included
>>> reading SPN to that example provisioning.
>>
>> Do you have specific examples?  To my knowledge the MVNOs should be
>> provisioning the SIM with a different MNC from the host but the network
>> used (and thus the network's MCC/MNC) are their host's.
> =

> I was not sure if all MVNOs have their own MNC, but in any case some
> operators use different trade names. Off the top of my hat I know our
> local Finnish operators Elisa and Sonera use trade names like Kolumbus
> and TeleFinland, and their name shown in UI needs to be correct.
> =


Being shown on the UI is a bit different from needing this information
to provision.  oFono already takes care of reading EFspn in the netreg
atom and figuring out the proper display name.

If you can rely on just the MCC/MNC of the SIM/IMSI for provisioning
information, that would greatly simplify your database and your plugin
implementation.

So I suggest you double check the need of EFspn first.

Regards,
-Denis

--===============4428623849969698382==--

