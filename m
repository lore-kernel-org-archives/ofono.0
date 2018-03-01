Content-Type: multipart/mixed; boundary="===============6681420059700493238=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 01 Mar 2018 12:27:42 +0100
Message-ID: <e10fa5c9-24ea-3af8-651f-2f43a49670e7@southpole.se>
In-Reply-To: <4a5f9819-3efc-20ed-4080-e958bafabf2a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6681420059700493238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/26/2018 05:12 PM, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 02/26/2018 08:37 AM, Jonas Bonn wrote:
>> The question is, what are the expectations here:
>> i)=C2=A0=C2=A0 What does it mean for connman to see two 'internet' conte=
xts =

>> since it sets up two services for them?
>> ii)=C2=A0 How is a modem supposed to roam between LTE and UMTS/GSM netwo=
rks =

>> when one requires an APN and the other does not.
>> iii) Not auto-connecting an LTE modem means not bringing it online; =

>> what implications does this have for connman?
>>
>> The above is currently a bit of a confusing mess and both ofono and =

>> connman get themselves tied in a knot when the modem switches between =

>> LTE and non-LTE techs.=C2=A0 Any guidance on how to approach this would =
be =

>> appreciated.
>>
> =

> The answer is to just fix your oFono driver.

OK... I fixed my driver. :)  I sent the patches a couple of minutes ago.

With that, things work much better.  connman doesn't choke on network =

tech transitions anymore.

There are still issues with connman related to this though:

Ofono does something like this on a tech transition to LTE:

Active: false
Attached: false
...
Attached: true
Active: true

When ofono does Attached: true, connman starts trying to set the context =

active which seems to result in InProgress.  connman doesn't seem to =

like the InProgress response and tries again, which ends up pounding the =

modem hard with "set active" messages until read_settings() returns (on =

the modem side) and the modem becomes Active (automatically) for real.

Similarly, on a transition from LTE to 3G, connman also tries to =

activate the context hundreds of times before it settles.  This =

behaviour is harder to understand:  connman has explicitly requested the =

activation here and should know that it's in progress...

What I think might be an issue here is the interplay between Attached =

and Active.  For LTE, Attached and Active are synonymous...(???) =

connman should not be setting Active for these at all.

Could ofono have Active set to true before Attached gets set true for =

the LTE context case so that connman never sees the context as =

Active:false?  Or is there a better way to handle this?

/Jonas

--===============6681420059700493238==--

