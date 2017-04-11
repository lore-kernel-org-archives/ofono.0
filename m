Content-Type: multipart/mixed; boundary="===============6293911395905142654=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Tue, 11 Apr 2017 12:07:40 -0500
Message-ID: <855e3bd4-b0c4-d61d-c17d-13b82814357d@gmail.com>
In-Reply-To: <20170411081818.19544-6-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6293911395905142654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/11/2017 03:18 AM, Jonas Bonn wrote:
> The LTE atom should watch the network status and automatically activate
> the default bearer when the modem becomes registered to the LTE network.
>
> This patch adds a device callback, activate_default_bearer(), to allow
> the device to start networking.

Nope, we're not doing it this way.  Once we're attached to LTE there's =

no need to activate a default bearer.  It is already active.  The modem =

should tell us that this is the case.

Another issue is that the network is free to ignore our default bearer =

setting, so you might be activating (or trying to) yet another context.

Doesn't QMI provide an equivalent of +CGEV?

Regards,
-Denis

--===============6293911395905142654==--

