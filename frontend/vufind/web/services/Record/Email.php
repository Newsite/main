<?php
/**
 * Email action for Record module
 *
 * PHP version 5
 *
 * Copyright (C) Villanova University 2007.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * @category VuFind
 * @package  Controller_Record
 * @author   Andrew S. Nagy <vufind-tech@lists.sourceforge.net>
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/building_a_module Wiki
 */
require_once 'Record.php';
require_once 'sys/Mailer.php';

/**
 * Email action for Record module
 *
 * @category VuFind
 * @package  Controller_Record
 * @author   Andrew S. Nagy <vufind-tech@lists.sourceforge.net>
 * @author   Demian Katz <demian.katz@villanova.edu>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/building_a_module Wiki
 */
class Email extends Record
{
    /**
     * Process incoming parameters and display the page.
     *
     * @return void
     * @access public
     */
    public function launch()
    {
        global $interface;
        global $configArray;

        if (isset($_POST['submit'])) {
            $result = $this->sendEmail(
                $_POST['to'], $_POST['from'],$_POST['subject'], $_POST['message']
            );
            if (!PEAR::isError($result)) {
                include_once 'Home.php';
                Home::launch();
                exit();
            } else {
                $interface->assign('errorMsg', $result->getMessage());
            }
        }

        // Display Page
        $interface->assign(
            'formTargetPath', '/Record/' . urlencode($_GET['id']) . '/Email'
        );
        if (isset($_GET['lightbox'])) {
            $interface->assign('title', $_GET['message']);
            return $interface->fetch('Record/email.tpl');
        } else {
            $interface->setPageTitle('Email Record');
            $interface->assign('subTemplate', 'email.tpl');
            $interface->setTemplate('view-alt.tpl');
            $interface->display('layout.tpl', 'RecordEmail' . $_GET['id']);
        }
    }

    /**
     * Send a record email.
     *
     * @param string $to      Message recipient address
     * @param string $from    Message sender address
     * @param string $message Message to send
     *
     * @return mixed          Boolean true on success, PEAR_Error on failure.
     * @access public
     */
    public function sendEmail($to, $from, $subject, $message)
    {
        global $interface;

        $subjects = $subject;
        $interface->assign('from', $from);
        $interface->assign('emailDetails', $this->recordDriver->getEmail());
        $interface->assign('recordID', $this->recordDriver->getUniqueID());
        $interface->assign('message', $message);
        $body = $interface->fetch('Emails/catalog-record.tpl');

        $mail = new VuFindMailer();
        return $mail->send($to, $from, $subjects, $body);
    }
}
?>
