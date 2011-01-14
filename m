Content-Type: multipart/mixed; boundary="===============0891875610650839022=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 09:47:20 +0200
Message-ID: <201101140947.20565.remi.denis-courmont@nokia.com>
In-Reply-To: <1294987983.29263.24.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0891875610650839022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 14 January 2011 08:53:03 ext Jukka Saunamaki, you wrote:
> Alternative is of cause to make provisioning synchronous, but that would
> limit what plugin can do (like asking SPN with ofono_sim_read())

Just because the plugin would be synchronous won't magically fix the "physi=
cal" =

race conditions. The user can still take the SIM out, and the network can =

still fail.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0891875610650839022==--

