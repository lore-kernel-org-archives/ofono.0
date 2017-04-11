Content-Type: multipart/mixed; boundary="===============5133474522111287501=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Tue, 11 Apr 2017 22:48:29 +0200
Message-ID: <03d7a73f-be7d-6c2f-8016-d5a8478f0e56@southpole.se>
In-Reply-To: <855e3bd4-b0c4-d61d-c17d-13b82814357d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5133474522111287501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/11/2017 07:07 PM, Denis Kenzior wrote:
> On 04/11/2017 03:18 AM, Jonas Bonn wrote:
>> The LTE atom should watch the network status and automatically activate
>> the default bearer when the modem becomes registered to the LTE network.
>>
>> This patch adds a device callback, activate_default_bearer(), to allow
>> the device to start networking.
>
> Nope, we're not doing it this way.  Once we're attached to LTE there's =

> no need to activate a default bearer.  It is already active.  The =

> modem should tell us that this is the case.
>
> Another issue is that the network is free to ignore our default bearer =

> setting, so you might be activating (or trying to) yet another context.
>
> Doesn't QMI provide an equivalent of +CGEV?

I haven't found an equivalent.  Right now it looks to me as though the =

only way to set up a PDP context is to call the "Start Networking" =

method.  If I don't start networking, the packet status callback never =

gives me a "connected" status.  It's not enough to just power on the =

modem... although that does get me registered to the network.

Furthermore, it doesn't matter what APN I use, I always get a usable =

data-connection.  "Get Settings" never returns an APN string, either, =

which makes me that the network is ignoring my setting altogether and =

just giving me a default bearer...???

If anyone knows how this is supposed to work, I'd appreciate some guidance!

/Jonas

--===============5133474522111287501==--

