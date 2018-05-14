Content-Type: multipart/mixed; boundary="===============6841716590221866514=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Fix AT+COLP=1 stalling VoiceCall creation in SIMCom
 SIM7100E
Date: Mon, 14 May 2018 11:11:45 -0500
Message-ID: <7955bce6-48d3-89f3-20a7-e5cb1ffca6aa@gmail.com>
In-Reply-To: <20180514134229.14050-1-bob.ham@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6841716590221866514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bob,

On 05/14/2018 08:42 AM, Bob Ham wrote:
> Setting AT+COLP=3D1 on the SIMCom SIM7100E causes oFono to stall and not
> create a new VoiceCall object.  We fix that by adding the SIMCOM
> vendor ID to the list for whom we set AT+COLP=3D0 instead.
> =


Both applied, thanks.

Regards
-Denis


--===============6841716590221866514==--

