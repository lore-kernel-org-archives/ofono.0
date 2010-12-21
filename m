Content-Type: multipart/mixed; boundary="===============3080482473624306425=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: TODO: Network updating the emergency number list
Date: Tue, 21 Dec 2010 14:02:46 -0600
Message-ID: <4D1107E6.4000403@gmail.com>
In-Reply-To: <1292948469.29886.224.camel@r82e1wc.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3080482473624306425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 12/21/2010 10:21 AM, Tikander Petteri wrote:
> Hi Rajesh and Denis,
> =

> If we are in area with multiple networks (so multiple MCCs), lets pass
> only received emergency-list from the servicing network, where ME is
> registered to, and discard possible notifications from other network's
> emergency-number notifications:

For sure we should not update the ECC list with numbers from outside the
current MCC.  However, it is less clear whether we can simply discard
the ECCs from other MCCs or still cache this information in some
fashion.  I suspect discarding them as a first implementation is
enough...  Either way, the core has to make the final decision, no
filtering should be done by the driver.

> =

> TS 22101, ch. 10.1
> "The UE shall regard these emergency numbers as valid in that country
> only (as identified by the MCC) and shall discard them when a new
> country is entered."
> =

> One think in one of those emails focusing on this discussion (Waldo's
> comment) was:
>> The modem will typically already analyze the new emergency-numbers,
>> filter out the ones that are not applicable and merge the numbers from
>> the various sources in the right priority....
> =

> My idea first in analyzing was to compare new emergency numbers with
> already sent emergency numbers (default-list/SIM EFecc-list), and send
> those up, if new emergency numbers compared to the old already sent ones
> were received. OK, probably in many cases modems will do this analyze
> itself, and send only new ones to the oFono. I don't know if it's
> actually dangerous, if oFono passes all network emergency numbers
> received from the modem (filtered or not by the modem). OK, then it's
> possible that some ECCs are reported twice. On the other hand, network
> ECCs (if MCC matches) should always be valid ones, suitable numbers, in
> spite of, where mobile is located. So it should be valid to acknowledge
> those new numbers always to UI in spite of, what numbers are sent to UI
> in initialization phase.
> =


22.101 exists for a reason.  Same with the 27.007 standard.  We should
implement the standard to the letter here.

> Perhaps then the only thing to be analyzed could be that country-code
> item.
> =

> Network downloaded emergency number-list can also contain emergency call
> type in the category-field (for instance "Police", "Ambulance"...). This
> kind of information is not included for example in SIM EFecc-file, so
> Emergency-number property returns in this moment just the ECC-number
> without the category. What do you think, should this also be included in
> the Emergency-property?

I believe the EFecc described in 31.102 also contains the category
information.  So we can certainly change the API to provide this
information or an empty string if unknown.  However, since the category
information is a bitmap, mapping this to an API in a nice manner can be
quite challenging.  Feel free to propose something.

Regards,
-Denis

--===============3080482473624306425==--

