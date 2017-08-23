Content-Type: multipart/mixed; boundary="===============5278579612410651351=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: Proposal: New SimAuth interface
Date: Wed, 23 Aug 2017 15:40:21 -0700
Message-ID: <eca28f35-c527-b86c-b641-96f96d640cfd@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5278579612410651351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

     The IWD project now has a need for SIM card access in order to =

authenticate to EAP-SIM/AKA WiFi networks, and will be using ofono for =

this functionality. In order to do this, the GSM/3G "authenticate" =

algorithm needs to be run on the (U)SIM. For this I am proposing a new =

interface: "org.ofono.SimAuth". I do have a few questions about what =

method(s)/interfaces would be preferred. Since 2G/3G take different =

inputs/outputs there are few possibilities:

1. Two different methods on org.ofono.SimAuth:

     AuthenticateSim()

         Input: "ay" RAND

         Output: "ay" SRES, "ay" KC

     AuthenticateUSim()

         Input: "ay" RAND, "ay" AUTN

         Output: "ay" RES, "ay" IK, "ay" CK, "ay" AUTS

2. One method on org.ofono.SimAuth, with more complex arguments e.g.

     Authenticate()

         Input: "s" type, a{ay} args

         Output: a{ay}

     This would return take in and return the correct arguments for =

2G/3G based on the "type" argument.

3. Separate interfaces for SIM/USIM (e.g. org.ofono.SimAuth and =

org.ofono.USimAuth). This would also allow the client to see if either =

SIM or USIM are supported before making any method calls.

If anyone has input on what would option would be preferred, or maybe a =

different way of doing it, that would be great!

Thanks,

James


--===============5278579612410651351==--

