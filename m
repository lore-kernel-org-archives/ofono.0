Content-Type: multipart/mixed; boundary="===============7307835155691156717=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA Support
Date: Thu, 25 Nov 2010 17:42:35 -0600
Message-ID: <4CEEF46B.5030404@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702CCBC1F@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7307835155691156717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

On 11/25/2010 10:06 AM, Rajesh.Nagaiah(a)elektrobit.com wrote:
> Hi Denis,
>  =

>> The proposal covers the basics of voice calls, data =

>> connections, messaging and network registration details.  The =

>> documentation can be found under:
>> doc/cdma-network-api.txt
>> doc/cdma-voicecall-manager-api.txt
> =

> Initially we discussed not to use voicecall manager for cdma, =

> rather only voicecall itself as we are going to have only =

> one call at the UE level ?

That is the intent, I simply named it VoicecallManager to be consistent
with the GSM interface name (e.g. Dial, SendTones, etc are on the
manager interface)  I don't mind naming this Voicecall if you feel this
would be better.

Regards,
-Denis

--===============7307835155691156717==--

