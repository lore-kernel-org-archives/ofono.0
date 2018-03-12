Content-Type: multipart/mixed; boundary="===============8444983366137868416=="
MIME-Version: 1.0
From: Eswaran Vinothkumar (BEG/PJ-IOT-EL) <Vinothkumar.Eswaran@de.bosch.com>
Subject: Wierd behaviour of ofono on MC7455 and Verizon sim card
Date: Mon, 12 Mar 2018 13:57:15 +0000
Message-ID: <139700fa88f64111ab9d547a0a9a1cd7@de.bosch.com>
In-Reply-To: <7e109768-30ae-de91-2acf-7de5a23db3e0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8444983366137868416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/08/2018 11:47 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: =

> ../ofono-1.22/drivers/qmimodem/devinfo.c:string_cb()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: =

> ../ofono-1.22/drivers/qmimodem/devinfo.c:qmi_query_serial()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: =

> ../ofono-1.22/drivers/qmimodem/sim.c:get_card_status_cb()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: =

> ../ofono-1.22/src/sim.c:ofono_sim_add_state_watch() 0x198d658

You would have to check the logic inside get_card_status_cb() to figure out=
 why the sim isn't being detected.

Hi,

Thanks for the hint. I looked into the source code of ofono and had identif=
ied the condition on which the sim card detection logic fails. =


The function handle_get_card_status_result() returns failure.  The Verizon =
SIM I used has 4 application running. The output of qmicli is shown below:

# qmicli -d /dev/cdc-wdm1 --uim-get-card-status [/dev/cdc-wdm1] Successfull=
y got card status Provisioning applications:
        Primary GW:   slot '0', application '2'
        Primary 1X:   slot '0', application '0'
        Secondary GW: session doesn't exist
        Secondary 1X: session doesn't exist Card [0]:
        Card state: 'present'
        UPIN state: 'not-initialized'
                UPIN retries: '0'
                UPUK retries: '0'
        Application [0]:
                Application type:  'csim (4)'
                Application state: 'ready'
                Application ID:
                        A0:00:00:03:43:10:02:F3:10:FF:FF:89:02:00:00:FF
                Personalization state: 'ready'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'disabled'
                        PIN1 retries: '3'
                        PUK1 retries: '10'
                PIN2 state: 'enabled-not-verified'
                        PIN2 retries: '3'
                        PUK2 retries: '10'
        Application [1]:
                Application type:  'isim (5)'
                Application state: 'detected'
                Application ID:
                        A0:00:00:00:87:10:04:F3:10:FF:FF:89:08:00:00:FF
                Personalization state: 'unknown'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'not-initialized'
                        PIN1 retries: '0'
                        PUK1 retries: '0'
                PIN2 state: 'not-initialized'
                        PIN2 retries: '0'
                        PUK2 retries: '0'
        Application [2]:
                Application type:  'usim (2)'
                Application state: 'ready'
                Application ID:
                        A0:00:00:00:87:10:02:F3:10:FF:FF:89:08:00:00:FF
                Personalization state: 'ready'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'disabled'
                        PIN1 retries: '3'
                        PUK1 retries: '10'
                PIN2 state: 'enabled-not-verified'
                        PIN2 retries: '3'
                        PUK2 retries: '10'
        Application [3]:
                Application type:  'unknown (0)'
                Application state: 'detected'
                Application ID:
                        A0:00:00:00:63:50:4B:43:53:2D:31:35
                Personalization state: 'unknown'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'not-initialized'
                        PIN1 retries: '0'
                        PUK1 retries: '0'
                PIN2 state: 'not-initialized'
                        PIN2 retries: '0'
                        PUK2 retries: '0'


The sim detection logic fails in the condition : =


			if ((index & 0xff) =3D=3D i && (index >> 8) =3D=3D n) {
				if (get_card_status(slot, info1, info2,sim_stat))
				{
					res =3D GET_CARD_STATUS_RESULT_TEMP_ERROR;
				}
				else
				{
                    				res =3D GET_CARD_STATUS_RESULT_OK;
				}
			}

In the condition check the slot number and application number is interchang=
ed. After fixing this, I could see that ofono is successfully detecting the=
 sim cards.

I will send a patch in my next e-mail

	Attached the patch to fix this issue. Please integrate it to the ofono .

Regards,
-Denis

--===============8444983366137868416==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-sim-detection-Fix-to-take-the-right-slot-and-application.patch"

RnJvbSBkMWVjNjZjNjQzZjAwNWQ1NThjNDAzYTY4YzdkZjA0YjA4MTlhYTc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiRXN3YXJhbiBWaW5vdGhrdW1hciAoQkVHLVBUL1BKLUlPVDEp
IgogPFZpbm90aGt1bWFyLkVzd2FyYW5AZGUuYm9zY2guY29tPgpEYXRlOiBNb24sIDEyIE1hciAy
MDE4IDE0OjQ2OjI4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gc2ltIGRldGVjdGlvbjogRml4IHRv
IHRha2UgdGhlIHJpZ2h0IHNsb3QgYW5kIGFwcGxpY2F0aW9uCiBudW1iZXIKCi0tLQogZHJpdmVy
cy9xbWltb2RlbS9zaW0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcW1pbW9kZW0vc2ltLmMgYi9kcml2
ZXJzL3FtaW1vZGVtL3NpbS5jCmluZGV4IDcxYzdlMDQuLjk5YzZkNjggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvcW1pbW9kZW0vc2ltLmMKKysrIGIvZHJpdmVycy9xbWltb2RlbS9zaW0uYwpAQCAtNTU3
LDcgKzU1Nyw3IEBAIHN0YXRpYyBlbnVtIGdldF9jYXJkX3N0YXR1c19yZXN1bHQgaGFuZGxlX2dl
dF9jYXJkX3N0YXR1c19yZXN1bHQoCiAKIAkJCWluZGV4ID0gR1VJTlQxNl9GUk9NX0xFKHN0YXR1
cy0+aW5kZXhfZ3dfcHJpKTsKIAotCQkJaWYgKChpbmRleCAmIDB4ZmYpID09IGkgJiYgKGluZGV4
ID4+IDgpID09IG4pIHsKKwkJCWlmICgoaW5kZXggJiAweGZmKSA9PSBuICYmIChpbmRleCA+PiA4
KSA9PSBpKSB7CiAJCQkJaWYgKGdldF9jYXJkX3N0YXR1cyhzbG90LCBpbmZvMSwgaW5mbzIsCiAJ
CQkJCQkJCXNpbV9zdGF0KSkKIAkJCQkJcmVzID0gR0VUX0NBUkRfU1RBVFVTX1JFU1VMVF9URU1Q
X0VSUk9SOwotLSAKMi43LjQKCg==

--===============8444983366137868416==--

