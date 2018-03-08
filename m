Content-Type: multipart/mixed; boundary="===============7889808512032822004=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 08 Mar 2018 06:49:35 +0100
Message-ID: <1c5b7a2b-b916-a896-3c6e-48969d9afa94@monom.org>
In-Reply-To: <cedae6d7-6dcf-5fab-823e-65ffbc8b5ad1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7889808512032822004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/02/2018 06:15 PM, Denis Kenzior wrote:
>> A lot of the above comes from my understanding of what connman is trying
>> to do:=C2=A0 if it sees the state as Attached and has no Active contexts=
 then
>> it starts trying to activate the first context.=C2=A0 Ideally, it would =
never
>> see an inactive context for LTE, at least not in the Attached state.
>> However, I may be missing something in my understanding of how this is
>> intended to work, so any clarification would be appreciated.
> =

> Or it should give up if it sees the InProgress error, but yes it might
> be that re-ordering messages is the right approach.  Daniel, Marcel?

I must admit, I am slightly confused. So we have a different behavior =

pattern between UMTS/GSM and LTE networks which expresses itself in the =

non ordering of Active and Attached?

Anyway, I don't have anything against ordering the events. Shouldn't be =

to hard to update the plugin.

Thanks,
Daniel

--===============7889808512032822004==--

