Content-Type: multipart/mixed; boundary="===============7235252639509998743=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ppp
Date: Sun, 15 Nov 2009 11:09:57 +0200
Message-ID: <200911151109.57998.remi@remlab.net>
In-Reply-To: <alpine.LNX.2.00.0911141915280.13597@boatman.intrepnet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7235252639509998743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le samedi 14 novembre 2009 21:26:38 Chris Pitchford, vous avez =C3=A9crit :
> When connecting to an APN for MMS services, there is the possibility of a
> clash of IP addresses both with other APN connections and with other
> internet connections (for example wifi)..

You'd have to implement TCP/IP in userspace also, which wouldn't be too nic=
e. =

With recent kernels (2.6.29 and up), you'd rather want to create a new netw=
ork =

kernel namespace, containing the MMS interface and the one or few processes =

sending or receiving MMS.

That avoids the IP range conflicts while not needing to reimplement TCP/IP.=
 It =

also still works if the modem exposes GPRS through sone kernel driver such =

that you cannot cleanly send and receive IP packets in userspace anyway. =

Currently, there aren't any in oFono, as both PPP and Phonet can provide IP =

packets to userspace. But that does not mean there won't ever be any.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============7235252639509998743==--

