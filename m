Content-Type: multipart/mixed; boundary="===============7326004500122832988=="
MIME-Version: 1.0
From: Rolf Offermanns <rolf.offermanns@gmx.net>
Subject: Huawei K3715 and E172 test results
Date: Thu, 02 Sep 2010 17:45:25 +0200
Message-ID: <4C7FC695.90809@gmx.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7326004500122832988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I did some tests with the following setup:

- Meego Netbook 1.0.x
- ofono git (1.9.2010)
  + Patch "[PATCH 1/2] huawei: poll sim state" from Kalle
- connman git (31.8.2010)
  + Patchset "[ofono-refactor-v2 PATCH xx] oFono API breakage, take 2"
  + Patchset "[service-leak PATCH xxx] fix service leak"
- EeePC 1005HA
- Huawei K3715 (Vodafone Mobile Connect USB)
- Huawei E172  (Vodafone Mobile Connect USB)

Below is a summary of the results. I have separate logfiles for each
test run with "OFONO_AT_DEBUG=3D1 ofonod -n -d '*'" output. Shall I post
them here?

Please let me know what I can do to improve the Huawei support.

Thanks to Kalle and Pekka for helping out on IRC.

-Rolf


Test run 1: Huawei K3715 with unlocked SIM (no PIN required)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
1. Start ofonod after modem has settled
   -> Everything is fine
   -> Modem shows up in connman
2. Unplug / plug
   -> First sysinfo shows sim_state: 0
   -> Later sysinfo calls return sim_state: 1 (checked in Minicom)
   -> Modem not detected in connman
3. Unplug / plug
   -> same as 2.
4. Unplug / plug
   -> same as 2.
5. Unplug / plug
   -> same as 2.

Summary: Modem only works if already settled before ofonod starts.


Test run 2: Huawei K3715 with locked SIM (PIN required)
Note: Whenever a "PIN required" showed up, I used the "tests/enter-pin"
script.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
1. Start ofonod after modem has settled
   -> Everything is fine
   -> Modem shows up in connman
2. Unplug / plug
   -> same as 1.
3. Unplug / plug
   -> enter-pin throws "DBus.Error.NoReply" exception
   -> Modem not detected in connman
4. Unplug / plug
   -> same as 3.
5. Unplug / plug
   -> same as 1.

Summary: Modem works if already settled before ofond starts and
sometimes when plugged in.


Test run 3: Huawei E172 with unlocked SIM (no PIN required)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
1. Start ofonod after modem has settled
   -> Everything is fine
   -> Modem shows up in connman
2. Unplug / plug
   -> First sysinfo shows sim_state: 255 (handled by Kalles patch)
   -> Next SYSINFO shows sim_state: 1
   -> Modem not detected in connman
3. Unplug / plug
   -> First sysinfo shows sim_state: 255
   -> Next SYSINFO shows sim_state: 0(!)
   -> Then a SIMST reply comes in (not there in 2.)
   -> Modem not detected in connman
4. Unplug / plug
   -> First sysinfo shows sim_state: 255
   -> Next SYSINFO shows sim_state: 0(!)
   -> No SIMST reply
   -> Modem not detected in connman
5. Unplug / plug
   -> First sysinfo shows sim_state: 255
   -> Next SYSINFO shows sim_state: 1
   -> Modem shows up in connman

Summary: Modem works if already settled before ofond starts and seldom
when plugged in. Several different behaviours are observed.



Test run 4: Huawei E172 with locked SIM (PIN required)
Note: Whenever a "PIN required" showed up, I used the "tests/enter-pin"
script.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
1. Start ofonod after modem has settled
   -> Everything is fine
   -> Modem shows up in connman
2. Unplug / plug
   -> AT chat gets out of sync early (no "right" reply after ATE0)
   -> Modem not detected in connman
3. Unplug / plug
    -> same as 1.
4. Unplug / plug
    -> same as 1.
5. Unplug / plug
   -> First sysinfo shows sim_state: 255
   -> Next SYSINFO gets no reply
      -> This happened quite often in other tests. The modem is still
         delivering replies to previous commands and the SYSINFO
         request seems to get lost.
   -> Modem not detected in connman

Summary: Modem works if already settled before ofond starts and seldom
when plugged in. Several different behaviours are observed.



--===============7326004500122832988==--

