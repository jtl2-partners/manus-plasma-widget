# Additional Features for Manus Monitor Widget

Based on the Manus API research, here are the additional metrics and features that can be integrated into the KDE Plasma widget.

## Currently Available API Endpoints

The Manus API currently provides these endpoints:
- **GET /v1/tasks** - List all tasks with filtering
- **GET /v1/tasks/{id}** - Get specific task details
- **GET /v1/projects** - List all projects
- **GET /v1/files** - List uploaded files

## Additional Metrics from Task Data

### Task Statistics
Each task in the API response includes a `credit_usage` field and status information. The widget can calculate:

1. **Active Tasks Count**
   - Filter tasks by `status: "running"`
   - Display count of currently executing tasks

2. **Completed Tasks Today**
   - Filter by `status: "completed"` and `createdAfter: today_timestamp`
   - Shows daily productivity

3. **Failed Tasks Count**
   - Filter by `status: "failed"`
   - Alerts user to issues requiring attention

4. **Task Success Rate**
   - Calculate: (completed tasks / total tasks) × 100%
   - Visual percentage indicator

5. **Average Credits Per Task**
   - Sum all `credit_usage` values / task count
   - Helps understand typical task costs

6. **Total Tasks This Month**
   - Filter by `createdAfter: month_start_timestamp`
   - Monthly activity tracking

7. **Credits by Task Status**
   - Breakdown: credits spent on completed vs failed tasks
   - Identifies wasted credits on failed tasks

### Recent Activity Feed
8. **Recent Tasks List**
   - Show last 5-10 tasks with:
     - Task title (from `metadata.task_title`)
     - Status (pending/running/completed/failed)
     - Credits used
     - Timestamp
   - Clickable links to task URLs (`metadata.task_url`)

## Project-Based Metrics

9. **Total Projects Count**
   - Simple count from GET /v1/projects

10. **Active Projects**
    - Projects with tasks created in last 7 days
    - Cross-reference project_id with tasks

11. **Project Selector**
    - Dropdown to filter metrics by specific project
    - Shows per-project statistics

## Time-Based Analytics

12. **Daily Credit Usage Trend**
    - Track credits spent per day over last 7 days
    - Simple line chart or sparkline

13. **Hourly Activity**
    - Tasks created/completed by hour
    - Identify peak usage times

14. **Monthly Comparison**
    - Compare current month vs previous month
    - Percentage change indicator

## File Storage Metrics

15. **Total Files Uploaded**
    - Count from GET /v1/files

16. **Storage Used**
    - If file size data is available in API response

## System Health Indicators

Since there's no dedicated health endpoint, we can derive health from task data:

17. **Derived Health Status**
    - **Healthy**: <5% failed tasks in last hour
    - **Degraded**: 5-20% failed tasks
    - **Unhealthy**: >20% failed tasks or no completed tasks in 1 hour

18. **API Response Time**
    - Measure latency of API calls
    - Alert if response time > 2 seconds

## Enhanced Visualizations

19. **Credit Usage Gauge**
    - Visual gauge showing percentage of credits used
    - Color-coded: green (0-50%), yellow (50-80%), red (80-100%)

20. **Task Status Pie Chart**
    - Visual breakdown of pending/running/completed/failed

21. **Mini Activity Graph**
    - Small sparkline showing task creation over time

## Alert Features

22. **Low Credit Warning**
    - Notification when credits < 10% remaining
    - Configurable threshold

23. **High Failure Rate Alert**
    - Notification when failure rate exceeds threshold

24. **Daily Usage Limit**
    - Alert when daily spending exceeds user-defined limit

## Widget Display Modes

25. **Compact Mode** (Panel)
    - Icon with health indicator dot
    - Tooltip showing key metrics on hover

26. **Standard Mode** (Desktop)
    - Current implementation with cards

27. **Detailed Mode** (Expanded)
    - All metrics visible
    - Recent activity feed
    - Mini charts

28. **Minimal Mode**
    - Only credits remaining and health status

## Implementation Priority

### High Priority (Easy to Implement)
- Active tasks count
- Completed tasks today
- Failed tasks count
- Total tasks this month
- Recent tasks list (last 5)
- Total projects count

### Medium Priority (Moderate Complexity)
- Task success rate
- Average credits per task
- Credits by task status
- Daily credit usage trend
- Project selector with filtering

### Low Priority (Complex/Nice-to-Have)
- Hourly activity analysis
- Mini charts and visualizations
- Alert notifications
- Monthly comparison analytics

## API Limitations

**Important Note**: The current Manus API does NOT have:
- Dedicated `/account` or `/usage` endpoint for credit balance
- System health/status endpoint
- Real-time credit balance information

The widget currently uses **mock data** for:
- Health status (derived from task failure rates)
- Credits spent this month (calculated from task credit_usage)
- Credits remaining (not available via API)

## Recommended Enhancements

To make the widget fully functional, we recommend:

1. **Calculate credits from tasks**: Sum `credit_usage` from all tasks in current month
2. **Derive health from task data**: Use task success/failure rates
3. **Add task activity dashboard**: Show recent tasks with status
4. **Implement project filtering**: Filter all metrics by selected project
5. **Add configurable alerts**: Notify on high failure rates or unusual activity

## Future API Endpoints Needed

For complete functionality, the Manus API would benefit from:
- `GET /v1/account` - Account details and credit balance
- `GET /v1/usage/summary` - Pre-calculated usage statistics
- `GET /v1/health` - System health status
- `GET /v1/usage/history` - Historical usage data with timestamps
