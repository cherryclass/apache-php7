<?php
/**
 * @author Tom Needham <tom@owncloud.com>
 *
 * @copyright Copyright (c) 2017, ownCloud GmbH
 * @license AGPL-3.0
 *
 * This code is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License, version 3,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License, version 3,
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

namespace OC\Settings\Panels\Admin;

use OC\Settings\Panels\Helper;
use OCP\IConfig;
use OCP\Settings\ISettings;
use OCP\Template;

class FileSharing implements ISettings {

	/** @var IConfig */
	protected $config;
	/** @var Helper */
	protected $helper;

	public function __construct(IConfig $config, Helper $helper) {
		$this->config = $config;
		$this->helper = $helper;
	}

	public function getPriority() {
		return 99;
	}

	public function getPanel() {
		$template = new Template('settings', 'panels/admin/filesharing');
		$template->assign('allowResharing', $this->config->getAppValue('core', 'shareapi_allow_resharing', 'yes'));
		$template->assign('shareAPIEnabled', $this->config->getAppValue('core', 'shareapi_enabled', 'yes'));
		$template->assign('allowLinks', $this->config->getAppValue('core', 'shareapi_allow_links', 'yes'));
		$template->assign('allowPublicUpload', $this->config->getAppValue('core', 'shareapi_allow_public_upload', 'yes'));
		$template->assign('enforceLinkPassword', $this->helper->isPublicLinkPasswordRequired());
		$template->assign('shareDefaultExpireDateSet', $this->config->getAppValue('core', 'shareapi_default_expire_date', 'no'));
		$template->assign('allowPublicMailNotification', $this->config->getAppValue('core', 'shareapi_allow_public_notification', 'no'));
		$template->assign('allowSocialShare', $this->config->getAppValue('core', 'shareapi_allow_social_share', 'yes'));
		$template->assign('allowGroupSharing', $this->config->getAppValue('core', 'shareapi_allow_group_sharing', 'yes'));
		$template->assign('onlyShareWithGroupMembers', $this->helper->shareWithGroupMembersOnly());
		$template->assign('allowMailNotification', $this->config->getAppValue('core', 'shareapi_allow_mail_notification', 'no'));
		$template->assign('allowShareDialogUserEnumeration', $this->config->getAppValue('core', 'shareapi_allow_share_dialog_user_enumeration', 'yes'));
		$template->assign('shareDialogUserEnumerationGroupMembers', $this->config->getAppValue('core', 'shareapi_share_dialog_user_enumeration_group_members', 'no'));
		$excludeGroups = $this->config->getAppValue('core', 'shareapi_exclude_groups', 'no') === 'yes' ? true : false;
		$template->assign('shareExcludeGroups', $excludeGroups);
		$excludedGroupsList = $this->config->getAppValue('core', 'shareapi_exclude_groups_list', '');
		$excludedGroupsList = json_decode($excludedGroupsList);
		$template->assign('shareExcludedGroupsList', !is_null($excludedGroupsList) ? implode('|', $excludedGroupsList) : '');
		$template->assign('shareExpireAfterNDays', $this->config->getAppValue('core', 'shareapi_expire_after_n_days', '7'));
		$template->assign('shareEnforceExpireDate', $this->config->getAppValue('core', 'shareapi_enforce_expire_date', 'no'));
		return $template;
	}

	public function getSectionID() {
		return 'sharing';
	}

}
